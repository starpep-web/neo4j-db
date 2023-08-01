from py2neo import Graph
from shared.config import NEO4J_DB_URI


def create_db_connection() -> Graph:
    return Graph(NEO4J_DB_URI)
