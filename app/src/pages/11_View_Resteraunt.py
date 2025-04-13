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

st.write(f"###  Here are restaurants by rating: ")

response = requests.get('http://api:4000/s/top-rest').json()


if "df" not in st.session_state:
    st.session_state.df = pd.DataFrame(response)

event = st.dataframe(
    st.session_state.df,
    on_select="rerun",
    selection_mode="single-row",
)
