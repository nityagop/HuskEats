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
restaurant_id = st.text_input("Restaurant ID")
name = st.text_input("Restaurant Name")
address = st.text_input("Address")
image = st.text_input("Main Image URL")
description = st.text_area("Description")
promo_image = st.text_input("Promotional Image URL")
menu_image = st.text_input("Menu Image URL")
hours = st.text_input("Operating Hours")
approval_status = st.selectbox("Approval Status", ["pending", "approved", "rejected"])


# Profile Data
profile_data = {
    "restaurant_id": restaurant_id,
    "name": name,
    "address": address,
    "image": image,
    "description": description,
    "promotional_image": promo_image,
    "menu_image": menu_image,
    "hours": hours,
    "approval_status": approval_status
}

# Create Profile Button
if st.button("Update Profile"):
    url = f"http://api:4000/r/restaurant_owners/profile/update"
    response = requests.put(url)
    # response = requests.put("http://api:4000/r/restaurant_owners/profile/update", json=profile_data)
    if response.status_code == 200:
        st.success("Profile updated successfully!")
    else:
        st.error(f"Error: {response.status_code}")

# if st.button("Update Profile"):
#     url = f"http://api:4000/r//restaurant_owners/profile/update/{restaurant_id}"
#     response = requests.put(url)
#     response_list = response.json()
#     if response.status_code == 200:
#         st.success("Profile updated!")
#     else:
#         st.error(f"Failed to update profile. Status code: {response.status_code}")


