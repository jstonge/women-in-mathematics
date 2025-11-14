Prompt:

Given the following biographical summary, return the following data in JSON format:
- full_name
- birthdate
- deathdate
- birthplace
- parents: [List of Parents]
- employment: [List of Employment]
- degrees: [List of Degrees]
- visits: [List of Visits]
- honors: [List of Honors]

where each Parent is a JSON object with keys
- name
- birthdate
- deathdate
- profession

Employment is a JSON object with keys
- employer
- job_title
- job_year_begin
- job_year_end
- reason_end

Degree is a JSON object with keys
- degree_institution_name
- degree_type (eg: BA, MA, PhD)
- degree_year
- degree_advisor

Visit is a JSON object with keys:
- visit_location
- visit_reason
- visit_year

Honors is a JSON object with keys:
- honor_name
- honor_year

---
