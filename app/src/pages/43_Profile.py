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

SideBarLinks()

# set the header of the page
st.header("Restaurant Profile")


# You can access the session state to make a more customized/personalized app experience
#st.write(f"### Welcome to your profile, {st.session_state['first_name']}!")

restaurant_id = 1
if restaurant_id:
    url = f"http://api:4000/r/restaurant_owners/profile/{restaurant_id}"
    response = requests.get(url)
    profile_list = response.json()
    profile = profile_list[0]

    # Display profile nicely
    st.header(f"🍽️ {profile['name']}")
    st.subheader(f"📍 Address: {profile['address']}")
    st.write(f"🕒 **Hours:** {profile['hours']}")
    st.write(f"📄 **Description:** {profile['description']}")
    st.write(f"✅ **Approval Status:** `{profile['approval_status']}`")



# Update Profile Button
st.header("Update Restaurant Profile")
# Input restaurant details
name = st.text_input("Restaurant Name")
address = st.text_input("Address")
image = st.text_input("Main Image URL")
description = st.text_area("Description")
promo_image = st.text_input("Promotional Image URL")
menu_image = st.text_input("Menu Image URL")
hours = st.text_input("Operating Hours")




# Update Profile Button
if st.button("Update Profile"):
    profile_data = {
    "restaurant_id": 1,
    "name": name,
    "address": address,
    "image": image,
    "description": description,
    "promotional_image": promo_image,
    "menu_image": menu_image,
    "hours": hours,
    "approval_status": 0
    }
    url = f"http://api:4000/r/restaurant_owners/profile/update"
    response = requests.put(url, json=profile_data)
    if response.status_code == 200:
        st.success("Profile updated successfully!")
    else:
        st.error(f"Error: {response.status_code}")
    st.rerun()

