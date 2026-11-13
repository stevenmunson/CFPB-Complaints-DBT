with source as (

    select * from {{ source('cfpb', 'raw_complaints') }}

),

renamed as (

    select
        -- ids and dates
        cast("Complaint ID" as integer)                       as complaint_id,
        cast("Date received" as date)                         as date_received,
        cast("Date sent to company" as date)                  as date_sent_to_company,

        -- what the complaint is about
        "Product"                                             as product,
        nullif(trim("Sub-product"), '')                       as sub_product,
        "Issue"                                               as issue,
        nullif(trim("Sub-issue"), '')                         as sub_issue,

        -- who is it about
        upper(trim("Company"))                                as company_name,

        -- who filed it and how
        nullif(trim("State"), '')                             as state_code,
        nullif(trim("ZIP code"), '')                          as zip_code,
        nullif(trim("Tags"), '')                              as tags,
        "Submitted via"                                       as submitted_via,

        -- how the company responded
        "Company response to consumer"                        as company_response,
        nullif(trim("Company public response"), '')           as company_public_response,
        "Timely response?" = 'Yes'                            as is_timely_response
    from source

),

deduplicated as (

    select * from renamed
    qualify row_number() over (partition by complaint_id order by date_received desc) = 1

)

select * from deduplicated