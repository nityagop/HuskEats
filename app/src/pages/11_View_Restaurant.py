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
st.header('Restaurants')

st.write(f"###  Select a restaurant for more information: ")

response = requests.get('http://api:4000/s/top-rest').json()


st.session_state.df = pd.DataFrame(response)

event = st.dataframe(
    st.session_state.df,
    column_order = [
            "Restaurant Name",
            "Address",
            "Rating",
        ],
    on_select="rerun",
    selection_mode="single-row",
)

selected_rows = event.selection["rows"]

if selected_rows:
    selected_index = selected_rows[0]
    selected_restaurant = response[selected_index]

    st.session_state.restaurant_name = selected_restaurant['Restaurant Name']
    st.session_state.restaurant_id = selected_restaurant['Restaurant ID']

    st.divider()
    st.write("### Restaurant Details")
    st.write(f"**Name:** {selected_restaurant['Restaurant Name']}")
    st.write(f"**Address:** {selected_restaurant['Address']}")
    st.write(f"**Description:** {selected_restaurant['Restaurant Description']}")

    left, right = st.columns(2)
    if left.button("View Restaurant Profile", use_container_width=True):
        st.switch_page('pages/14_View_ProfileOfRestaurant.py')

    if right.button("Write Review", type="primary", use_container_width=True):
        st.switch_page('pages/15_ReviewForRest.py')