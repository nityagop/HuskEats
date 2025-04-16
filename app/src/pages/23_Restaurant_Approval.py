import logging
logger = logging.getLogger(__name__)

import streamlit as st
import pandas as pd
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('Review Restaurants Requiring Approval')
st.write('### Restaurants Requiring Approval')

restaurants = requests.get('http://api:4000/a/restaurants').json()


st.write("Please approve or deny them in the table below.")

if "df" not in st.session_state:
    st.session_state.df = pd.DataFrame(restaurants)

event = st.dataframe(
    st.session_state.df,
    column_order = [
            "Restaurant ID",
            "Restaurant Name",
            "Address",
            "Restaurant Description",
            "Hours of Operation",
            "approval_status",
        ],
    on_select="rerun",
    selection_mode="single-row",
)

selected_rows = event.selection["rows"]
if selected_rows:
    selected_index = selected_rows[0]
    selected_restaurant = restaurants[selected_index]

    st.session_state.restaurant_name = selected_restaurant['Restaurant Name']
    st.session_state.restaurant_id = selected_restaurant.get('Restaurant ID')

    st.divider()
    st.write("### Restaurant Details")
    st.write(f"**Name:** {selected_restaurant['Restaurant Name']}")
    st.write(f"**Address:** {selected_restaurant['Address']}")
    st.write(f"**Description:** {selected_restaurant['Restaurant Description']}")
    
    left, middle, right = st.columns(3)
    if left.button("View Restaurant Profile", use_container_width=True):
        st.switch_page('pages/14_View_ProfileOfRestaurant.py')


    if middle.button("Approve", type="primary", use_container_width=True):
        restApproval = requests.put(f"http://api:4000/a/restaurant/{selected_restaurant['Restaurant ID']}/approve")
        st.write("Restaurant approved successfully!")
    if right.button("Reject", type="primary", use_container_width=True):
        restApproval = requests.put(f"http://api:4000/a/restaurant/{selected_restaurant['Restaurant ID']}/reject")
        st.write("Restaurant rejected. Restaurant can be approved later.")
 
