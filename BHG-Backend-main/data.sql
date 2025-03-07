-- Insert data into referral_structure
INSERT INTO referral_structure (entity_id, referral_entity_id, root_id) VALUES ('146257', '146229', '146257');
INSERT INTO referral_structure (entity_id, referral_entity_id, root_id) VALUES ('146257', '146254', '146257');
INSERT INTO referral_structure (entity_id, referral_entity_id, root_id) VALUES ('146229', '146222', '146257');
INSERT INTO referral_structure (entity_id, referral_entity_id, root_id) VALUES ('146254', '146258', '146257');
INSERT INTO referral_structure (entity_id, referral_entity_id, root_id) VALUES ('146222', '146256', '146257');
INSERT INTO referral_structure (entity_id, referral_entity_id, root_id) VALUES ('146222', '146168', '146257');

-- Insert data into referral
INSERT INTO referral (entity_id, referral_entity_id, rate) VALUES ('146257', '146229', 0.1);
INSERT INTO referral (entity_id, referral_entity_id, rate) VALUES ('146257', '146254', 0.1);
INSERT INTO referral (entity_id, referral_entity_id, rate) VALUES ('146257', '146222', 0.1);
INSERT INTO referral (entity_id, referral_entity_id, rate) VALUES ('146257', '146258', 0.1);
INSERT INTO referral (entity_id, referral_entity_id, rate) VALUES ('146257', '146256', 0.1);
INSERT INTO referral (entity_id, referral_entity_id, rate) VALUES ('146257', '146168', 0.1);
INSERT INTO referral (entity_id, referral_entity_id, rate) VALUES ('146229', '146222', 0.1);
INSERT INTO referral (entity_id, referral_entity_id, rate) VALUES ('146229', '146256', 0.1);
INSERT INTO referral (entity_id, referral_entity_id, rate) VALUES ('146254', '146258', 0.1);
INSERT INTO referral (entity_id, referral_entity_id, rate) VALUES ('146222', '146256', 0.1);
INSERT INTO referral (entity_id, referral_entity_id, rate) VALUES ('146222', '146168', 0.1);

-- 146000 1 146257
-- 9899999999 2 146229
-- 696969696969 3 146254
-- 146259 4 146222
-- 146258 5 
-- 146256 6

INSERT INTO tags (name, abn) VALUES ('tag_test_1', '123456789');
INSERT INTO tags (name, abn) VALUES ('tag_test_2', '987654321');
INSERT INTO tags (name, abn) VALUES ('tag_test_3', '543216789');

INSERT INTO fund_tag (tag_id, fund_id) VALUES (1, 79);
INSERT INTO fund_tag (tag_id, fund_id) VALUES (1, 78);
INSERT INTO fund_tag (tag_id, fund_id) VALUES (1, 77);
INSERT INTO fund_tag (tag_id, fund_id) VALUES (2, 76);