SELECT toStartOfDay(reqTimeSec) as timestamp_day,\nstatusCode,\nreqHost,\ncity,\nstate,\ncountry,\nerrorCode,\nreqMethod,\nrspContentType,\ncp,\ncacheStatus,\ncount() as cnt_all,\ncountIf(cacheStatus = 0) as cnt_originHits,\ncountIf(cacheStatus = 1) as cnt_edgeHits,\ncnt_edgeHits / count() * 100 as pct_offLoadHit,\nsum(totalBytes) as sum_totalBytes,\nsumIf(totalBytes, cacheStatus = 0) as sum_BytesOrigin,\nsumIf(totalBytes, cacheStatus = 1) as sum_BytesEdge,\nsum_BytesEdge / sum_totalBytes * 100 as pct_offLoadBytes,\ncountIf(statusCode > 400) as cnt_errorHits,\ncnt_errorHits / count() * 100 as pct_errorRate,\nuniq (cliIP) as uniq_cliIP,\nuniq (cliIP, UA) as uniq_session,\nquantiles (0.25, 0.5, 0.75, 0.9, 0.95, 0.99) (turnAroundTimeMSec) as quantiles_turnAroundTimeMSec,\nquantiles (0.25, 0.5, 0.75, 0.9, 0.95, 0.99) (transferTimeMSec) as quantiles_transferTimeMSec,\ntopK (50) (cliIP) as top_50_cliIP,\ntopK (50) (UA) as top_50_UA,\ntopK (50) (reqPath) as top_50_reqPath,\nuniq(reqPath) as uniq_reqPath,\navg(turnAroundTimeMSec) as avg_turnAroundTimeMSec,\navg(transferTimeMSec) as avg_transferTimeMSec,\navg(reqEndTimeMSec) as avg_reqEndTimeMSec,\navg(dnsLookupTimeMSec) as avg_dnsLookupTimeMSec,\navg(tlsOverheadTimeMSec) as avg_tlsOverheadTimeMSec,\ncountIf(tlsOverheadTimeMSec > 0) as cnt_tls,\ncountIf(reqEndTimeMSec > 0) as cnt_reqEnd,\ncountIf(dnsLookupTimeMSec > 0) as cnt_dnsLookup,\ncountIf(turnAroundTimeMSec > 0) as cnt_turnAround,\ncountIf(transferTimeMSec > 0) as cnt_transfer,\ncountIf(Edge_DNSLookupTime > 0) as cnt_edgeLookup,\navg(Edge_DNSLookupTime) as avg_edgeLookup,\navg(Edge_RequestEndTime) as avg_edgeRequest,\ncountIf(Edge_TurnAroundTime > 0) as cnt_edgeTurnAround,\navg(Edge_TurnAroundTime) as avg_edgeTurnAround,\ncountIf(Origin_DNSLookupTime > 0) as cnt_originLookup,\navg(Origin_DNSLookupTime) as avg_originLookup,\navg(Origin_RequestEndTime) as avg_originRequest,\ncountIf(Origin_TurnAroundTime > 0) as cnt_originTurnAround,\ncnt_originTurnAround / cnt_edgeTurnAround as pct_originRequests,\ncountIf(Parent_DNSLookupTime > 0) as cnt_parentLookup,\navg(Parent_DNSLookupTime) as avg_parentLookup,\navg(Parent_RequestEndTime) as avg_parentRequest,\ncountIf(Parent_TurnAroundTime > 0) as cnt_parentTurnAround,\ncnt_parentTurnAround / cnt_edgeTurnAround as pct_parentRequests,\ncountIf(Peer_DNSLookupTime > 0) as cnt_peerLookup,\navg(Peer_DNSLookupTime) as avg_peerLookup,\navg(Peer_RequestEndTime) as avg_peerRequest,\ncountIf(Peer_TurnAroundTime > 0) as cnt_peerTurnAround,\ncnt_peerTurnAround / cnt_edgeTurnAround as pct_peerRequests,\nuniq(country) as uniq_country,\nuniq(edgeIP) as uniq_edgeIP,\navg(totalBytes) as avg_totalBytes,\nquantiles (0.25, 0.5, 0.75, 0.9, 0.95, 0.99) (totalBytes) as quantiles_totalBytes\nFROM akamai.logs\nGROUP BY\ntimestamp_day,\nstatusCode,\nreqHost,\ncity,\nstate,\ncountry,\nerrorCode,\nreqMethod,\nrspContentType,\ncp,\ncacheStatus\nSETTINGS hdx_primary_key = 'timestamp_day'