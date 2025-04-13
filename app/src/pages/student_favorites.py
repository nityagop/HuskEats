import logging
logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from streamlit_extras.app_logo import add_logo
import world_bank_data as wb
import matplotlib.pyplot as plt
import numpy as np
import plotly.express as px
from modules.nav import SideBarLinks
import requests

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('Favorites')

st.write(f"### Hi, {st.session_state['first_name']}! Here are your favorite restaurants: ")

response = requests.get(f'http://api:4000/favorites/{user_id}')


if response.status_code == 200:
    data = response.json()
    print("Data:", data)
else:
    print("Request failed with status:", response.status_code)




