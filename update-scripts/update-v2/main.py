import os
import pandas as pd
from shared.database import create_db_connection
from data import parse_df, CREATE_QUERY


def main():
    db = create_db_connection()

    current_directory = os.path.dirname(os.path.abspath(__file__))
    data_directory = os.path.join(current_directory, 'data')
    data_csv = os.path.join(data_directory, 'Hemopi_R_GAAC.csv')

    print(f'Reading data CSV: {data_csv}')
    df = pd.read_csv(data_csv)
    print('Finished reading CSV, now parsing...')
    parsed_data = parse_df(df)
    print('Finished parsing data.')

    print('Transaction begins.')
    tx = db.begin()
    size = len(parsed_data.items())
    for index, (identifier, props) in enumerate(parsed_data.items()):
        params = {
            'id': identifier,
            'props': props
        }

        print(f'[{index + 1} / {size}] - Inserting data for starPep_{identifier}...')
        tx.run(CREATE_QUERY, parameters=params)

    print('Committing changes...')
    db.commit(tx)
    print('Changes committed.')


if __name__ == '__main__':
    main()
