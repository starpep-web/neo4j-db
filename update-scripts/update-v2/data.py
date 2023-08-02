from typing import Dict, Union
import pandas as pd
import numpy as np


_RELATIONSHIP_NAME = 'characterized_by'
_NODE_LABEL = 'Attributes'


CREATE_QUERY = f'MATCH (n:Peptide) WHERE ID(n) = $id CREATE (n)-[:{_RELATIONSHIP_NAME}]->(:{_NODE_LABEL} $props)'


HemolyticData = Dict[str, Union[float, int]]


def extract_id(star_pep_id: str) -> int:
    return int(star_pep_id.split('_')[1])


def parse_df(df: pd.DataFrame) -> Dict[int, HemolyticData]:
    uninteresting_columns = {'peptide', 'sequence', 'length'}
    interesting_columns = set(df.keys()) - uninteresting_columns

    data_by_peptide = dict()

    for i in range(0, len(df)):
        row = df.iloc[i]
        star_pep_id = row['peptide']
        extracted_id = extract_id(star_pep_id)

        data_for_peptide = dict()
        for prop in interesting_columns:
            prop_data = row[prop]

            if isinstance(prop_data, np.float64):
                prop_data = float(prop_data)
            elif isinstance(prop_data, np.int64):
                prop_data = int(prop_data)

            data_for_peptide[prop] = prop_data

        data_by_peptide[extracted_id] = data_for_peptide

    return data_by_peptide

