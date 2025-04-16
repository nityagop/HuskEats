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

if selected_rows:
    selected_index = selected_rows[0]
    selected_restaurant = response[selected_index]

    st.session_state.restaurant_name = selected_restaurant['Restaurant Name']
    st.session_state.restaurant_id = selected_restaurant.get('Restaurant ID')


    st.divider()
    st.write("### Restaurant Details")
    st.write(f"**Name:** {selected_restaurant['Restaurant Name']}")
    st.write(f"**Address:** {selected_restaurant['Address']}")
    st.write(f"**Description:** {selected_restaurant['Restaurant Description']}")

    left, right = st.columns(2)
    if left.button("View Restaurant Profile", use_container_width=True):
        st.switch_page('pages/14_View_ProfileOfRestaurant.py')

    restaurant_id = selected_restaurant.get("restaurant_id")
    if right.button("Remove Favorite", type="primary", use_container_width=True):
        try:
            delete_response = requests.delete(
                f"http://api:4000/s/favorites/{user_id}/{restaurant_id}")
            if delete_response.status_code == 200:
                st.success("Favorite successfully removed!")
                st.rerun()
            else:
                st.error("Failed to delete favorite.")
        except Exception as e:
            st.error(f"Error deleting favorite: {e}")