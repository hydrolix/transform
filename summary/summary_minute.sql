SELECT toStartOfMinute(reqTimeSec) as timestamp_min,\nstatusCode,\nasn,\ncity,\nstate,\ncountry,\ncacheable,\nerrorCode,\nreqMethod,\nrspContentType,\nproto,\ncp,\ncount() as cnt_all,\ncountIf(cacheStatus = 0) as cnt_originHits,\ncountIf(cacheStatus = 1) as cnt_edgeHits,\ncnt_edgeHits / count() * 100 as pct_offLoadHit,\nsum(totalBytes) as sum_totalBytes,\nsumIf(totalBytes, cacheStatus = 0) as sum_BytesOrigin,\nsumIf(totalBytes, cacheStatus = 1) as sum_BytesEdge,\nsum_BytesEdge / sum_totalBytes * 100 as pct_offLoadBytes,\ncountIf(statusCode > 400) as cnt_errorHits,\ncnt_errorHits / count() * 100 as pct_errorRate,\nuniq (cliIP) as uniq_cliIP,\nuniq (cliIP, UA) as uniq_session,\nquantiles (0.25, 0.5, 0.75, 0.9, 0.95, 0.99) (turnAroundTimeMSec) as quantiles_turnAroundTimeMSec,\nquantiles (0.25, 0.5, 0.75, 0.9, 0.95, 0.99) (transferTimeMSec) as quantiles_transferTimeMSec,\ntopK (50) (cliIP) as top_50_cliIP,\ntopK (50) (UA) as top_50_UA,\ntopK (50) (reqPath) as top_50_reqPath\nFROM akamai.logs\nGROUP BY\ntimestamp_min,\nstatusCode,\nreqHost,\nasn,\ncity,\nstate,\ncountry,\ncacheable,\nerrorCode,\nreqMethod,\nrspContentType,\nreqHost,\nproto,\ncp\nSETTINGS hdx_primary_key = 'timestamp_min'