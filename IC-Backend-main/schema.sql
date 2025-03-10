DROP TABLE IF EXISTS referral;
DROP TABLE IF EXISTS referral_structure;
DROP TABLE IF EXISTS fund_tag;
DROP TABLE IF EXISTS tags CASCADE;

CREATE TABLE IF NOT EXISTS referral (
    referral_id         BIGSERIAL PRIMARY KEY,
    entity_id           VARCHAR(255) NOT NULL,
    referral_entity_id  VARCHAR(255) NOT NULL,
    rate                DECIMAL NOT NULL
);

CREATE TABLE IF NOT EXISTS referral_structure (
    id                  BIGSERIAL PRIMARY KEY,
    entity_id           VARCHAR(255) NOT NULL,
    referral_entity_id  VARCHAR(255) NOT NULL,
    root_id             BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS tags (
    tag_id              BIGSERIAL PRIMARY KEY,
    name                VARCHAR(255) NOT NULL,
    abn                 VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS fund_tag (
    tag_id              BIGSERIAL,
    fund_id             BIGINT,
    PRIMARY KEY (tag_id, fund_id),
    -- FOREIGN KEY (fund_id) REFERENCES funds(id),
    FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
);