SELECT 
    accession.id,
    accession.title,
    accession.identifier,
    accession.accession_date, 
    accession.condition_description, 
    e1.value AS "aquisition_type",
    e2.value AS "resource_type", 
    accession.publish,
    accession.access_restrictions,
    accession.access_restrictions_note, 
    accession.use_restrictions, 
    accession.use_restrictions_note, 
    accession.lock_version, 
    accession.created_by, 
    accession.last_modified_by, 
    repository.name AS "repository_name",
    e4.value AS "label", 
    date.expression,
    e3.value AS "date_type", 
    date.begin,
    date.end, 
    e6.value AS "portion", 
    extent.container_summary, 
    extent.number, 
    e5.value AS "extent_type", 
    e7.value AS "processing_priority", 
    e8.value AS "processing_status", 
    ud.boolean_1 AS "deed_of_gift", 
    ud.real_1 AS "appraisal_value",
    ud.real_2 AS "external_appraisal_value", 
    ud.real_3 AS "purchase_value", 
    ud.text_1 AS "Notes on Value", 
    resource.identifier AS "resource_identifier", 
    resource.title AS "resource_title", 
    resource.ead_id
FROM `accession` 
LEFT JOIN `repository`
	ON accession.repo_id = repository.id
LEFT JOIN date
  ON accession.id = date.accession_id
LEFT JOIN `extent`
  ON accession.id = extent.accession_id
LEFT JOIN `collection_management`
  ON accession.id = collection_management.accession_id
LEFT JOIN user_defined ud
  ON accession.id = ud.accession_id
LEFT JOIN `resource` 
  ON accession.id = resource.accession_id
LEFT JOIN `enumeration_value` e1
  ON accession.acquisition_type_id=e1.id
LEFT JOIN `enumeration_value` e2
  ON accession.resource_type_id=e2.id
LEFT JOIN `enumeration_value` e3
  ON date.date_type_id=e3.id
LEFT JOIN `enumeration_value` e4
  ON date.label_id=e4.id
LEFT JOIN `enumeration_value` e5
  ON extent.extent_type_id=e5.id
LEFT JOIN `enumeration_value` e6
  ON extent.portion_id=e6.id
LEFT JOIN `enumeration_value` e7
  ON collection_management.processing_priority_id=e7.id
LEFT JOIN `enumeration_value` e8
  ON collection_management.processing_status_id=e8.id;