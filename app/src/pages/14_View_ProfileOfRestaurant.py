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

restaurant_id = st.session_state.get("restaurant_id")
restaurant_name = st.session_state.get("restaurant_name", "Unknown Restaurant")

if restaurant_id:
    url = f"http://api:4000/r/restaurant_owners/profile/{restaurant_id}"
    response = requests.get(url)
    profile_list = response.json()
    profile = profile_list[0]

    # Display profile nicely
    st.header(f"🍽️ {profile['name']}")
    st.divider()
    st.write(f"### 📍 Address: {profile['address']}")
    st.write(f"### 🕒 **Hours:** {profile['hours']}")
    st.write(f"#### 📄 **Description:** {profile['description']}")
