-- bit check

CREATE TABLE bittmp (a bit(33));

\copy bittmp from 'data/bit.data'

SET enable_seqscan=on;

SELECT count(*) FROM bittmp WHERE a <   '011011000100010111011000110000100';

SELECT count(*) FROM bittmp WHERE a <=  '011011000100010111011000110000100';

SELECT count(*) FROM bittmp WHERE a  =  '011011000100010111011000110000100';

SELECT count(*) FROM bittmp WHERE a >=  '011011000100010111011000110000100';

SELECT count(*) FROM bittmp WHERE a >   '011011000100010111011000110000100';

SET client_min_messages = DEBUG1;
CREATE INDEX bitidx ON bittmp USING GIST ( a );
CREATE INDEX bitidx_b ON bittmp USING GIST ( a ) WITH (buffering=on);
DROP INDEX bitidx_b;
RESET client_min_messages;

SET enable_seqscan=off;

SELECT count(*) FROM bittmp WHERE a <   '011011000100010111011000110000100';

SELECT count(*) FROM bittmp WHERE a <=  '011011000100010111011000110000100';

SELECT count(*) FROM bittmp WHERE a  =  '011011000100010111011000110000100';

SELECT count(*) FROM bittmp WHERE a >=  '011011000100010111011000110000100';

SELECT count(*) FROM bittmp WHERE a >   '011011000100010111011000110000100';

-- Test index-only scans
SET enable_bitmapscan=off;
EXPLAIN (COSTS OFF)
SELECT a FROM bittmp WHERE a BETWEEN '1000000' and '1000001';
