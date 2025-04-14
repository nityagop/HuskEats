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

restaurant_id = 1

st.header('Overall Ratings')

st.write(f"### Hi, {st.session_state['first_name']}! Here are your ratings:")

if restaurant_id:
    url = f"http://api:4000/r/restaurant_owners/{restaurant_id}"
    response = requests.get(url)

    if response.status_code == 200:
       data = response.json()
       df = pd.DataFrame(data)
       st.dataframe(df)
    else:
        st.error(f"Request failed with status: {response.status_code}")
else:
    st.info("Please enter your restaurant ID in the sidebar.")



