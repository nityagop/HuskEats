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
user_id = st.session_state.get('user_id')
user_id = 1 # for testing purposes

# set the header of the page
st.header('Favorites')

st.write(f"### Hi, {st.session_state['first_name']}! Here are your favorite restaurants: ")

response = requests.get(f'http://api:4000/s/favorites/{user_id}').json()
if not response:
    st.info("You have no favorite restaurants yet!")
else:
    if "df" not in st.session_state:
        st.session_state.df = pd.DataFrame(response)

    event = st.dataframe(
        st.session_state.df,
        column_order = [
            "Restaurant Name",
            "Address",
            "Rating",
            "Restaurant Description",
        ],
        on_select="rerun",
        selection_mode="single-row",
    )

    selected_rows = event.selection["rows"]



