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
# set the header of the page
st.header('Profile')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Welcome to your profile, {st.session_state['first_name']}!")


st.title("Hours of Operations")

hours_data = requests.get('http://api:4000/r/restaurant_owners/profile').json()

df = st.dataframe(hours_data)
st.table(df)

