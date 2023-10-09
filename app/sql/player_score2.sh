#!/bin/bash

for db in ../../initial_data/*.db; do
  sqlite3 $db "DROP TABLE player_score2;CREATE TABLE player_score2 (
    tenant_id BIGINT NOT NULL,
    player_id VARCHAR(255) NOT NULL,
    competition_id VARCHAR(255) NOT NULL,
    score BIGINT NOT NULL,
    row_num BIGINT NOT NULL,
    created_at BIGINT NOT NULL,
    updated_at BIGINT NOT NULL,
    PRIMARY KEY(tenant_id, player_id, competition_id)
  );CREATE INDEX idx_player_score_row_num ON player_score2(row_num);insert into player_score2 select  player_score.tenant_id,  player_score.player_id,  player_score.competition_id, score, row_num, created_at, updated_at from player_score JOIN (select ps.tenant_id, ps.player_id, ps.competition_id, MAX(ps.row_num) AS max_row_num from player_score AS ps group by tenant_id, player_id, competition_id) AS max_player_score ON player_score.row_num = max_player_score.max_row_num AND player_score.tenant_id=max_player_score.tenant_id AND player_score.player_id=max_player_score.player_id AND player_score.competition_id=max_player_score.competition_id;"
done
