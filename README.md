# Inscape Media Demo

A compact dbt project that turns raw Inscape viewing data into documented, tested consumer media-consumption marts.

## Project layout

- `models/sources.yml` — RAW Snowflake source declarations and source-level tests.
- `models/staging/` — Source normalization and deterministic event deduplication.
- `models/intermediate/` — Consumer identity mapping and title metadata enrichment.
- `models/marts/` — Demo-ready detail and daily consumer media-consumption marts.
- `models/inscape.yml` — Model documentation and data-quality tests.

## Data flow

`RAW_INSCAPE_VIEWING_EVENTS`, `RAW_BLU_DEVICE_GRAPH`, and `RAW_BLU_TITLE_METADATA` feed three staging models. The intermediate model maps valid viewing events to `BLU_ID` and attaches metadata. Two marts publish the event-level detail and daily consumer summary.

## Run the demo

```bash
dbt build
```

The build creates six models and runs source and model data tests end to end.

## Published marts

- `daily_blu_fact_media_detail` — One valid, consumer-mapped viewing event per row.
- `daily_blu_fact_media_summary` — One row per `BLU_ID` and viewed date, with distinct title, network, genre, device, and service lists.
