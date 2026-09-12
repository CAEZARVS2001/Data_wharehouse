"""
This code extracts the csv files from raw/data/ and stores the information 
aggregating the date of loading and csv of origin in a data wharehouse bronze medallion
"""

import pandas as pd
from sqlalchemy import create_engine
from pathlib import Path
from datetime import datetime


# Import from .env file
from dotenv import load_dotenv
import os

load_dotenv()
olist_user_password = os.getenv('OLIST_USER_PASSWORD')


engine = create_engine('postgresql://olist_user:' + str(olist_user_password) + '@localhost:5432/dw_olist')

# Data ingestion
RAW_DIR = Path("data/raw")

for csv_file in RAW_DIR.glob("*.csv"):

    table_name = f"bronze_{csv_file.stem}"

    df = pd.read_csv(csv_file)
    df["_ingested_at"] = datetime.now()
    df["_source_file"] = csv_file.name
    df.to_sql(table_name, engine, schema='bronze', if_exists='replace', index=False)

    print(f"Load: {table_name} ({len(df)} rows, {len(df.columns)} columns)")

