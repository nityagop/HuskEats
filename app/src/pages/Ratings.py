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
st.header('Overall Ratings')


# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}! Here are your ratings: ")

ratings_response = requests.get('http://api:4000/r/restaurant_owners').json()

if ratings_response.status_code == 200:
    data = ratings_response.json()
    print("Data:", data)
else:
    print("Request failed with status:", ratings_response.status_code)






