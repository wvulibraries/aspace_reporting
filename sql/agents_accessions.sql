SELECT 
    agents.accession_id, 
    e1.value AS 'role', 
    e2.value AS 'relator', 
    ac.name,
    e3.value AS 'salutation', 
    ac.address_1 AS 'address1', 
    ac.address_2 AS 'address2',
    ac.city, 
    ac.region, 
    ac.country, 
    ac.post_code, 
    ac.email, 
    ac.email_signature, 
    ac.note  
FROM linked_agents_rlshp agents
LEFT JOIN enumeration_value e1  
    ON e1.id = agents.role_id
LEFT JOIN enumeration_value e2  
    ON e2.id = agents.relator_id 
LEFT JOIN agent_contact ac
    ON agents.agent_person_id = ac.agent_person_id
    OR agents.agent_family_id = ac.agent_family_id
    OR agents.agent_corporate_entity_id = ac.agent_corporate_entity_id 
    OR agents.agent_software_id = ac.agent_software_id 
LEFT JOIN enumeration_value e3
    ON e3.id = ac.salutation_id
WHERE agents.accession_id IS NOT NULL
ORDER BY agents.accession_id;