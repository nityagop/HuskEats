import logging

logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout="wide")

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Restaurant Owner, {st.session_state['first_name']}.")
st.write("")
st.write("")
st.write("### What would you like to do today?")

if st.button("View my Ratings", type="primary", use_container_width=True):
    st.switch_page("pages/41_Ratings.py")

if st.button("Reply to Reviews", type="primary", use_container_width=True):
    st.switch_page("pages/42_MyReviews.py")

if st.button("View Profile", type="primary", use_container_width=True):
    st.switch_page("pages/43_Profile.py")
