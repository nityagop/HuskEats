import logging

logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout="wide")

SideBarLinks()

st.title(f"Welcome {st.session_state['first_name']}.")
st.write("### What would you like to do today?")

if st.button("View Resturaunts", type="primary", use_container_width=True):
    st.switch_page("pages/11_View_Restaurant.py")

if st.button("View my Favorites", type="primary", use_container_width=True):
    st.switch_page("pages/13_Student_Favorites.py")

if st.button("Write Reviews", type="primary", use_container_width=True):
    st.switch_page("pages/12_Write_Reviews.py")
