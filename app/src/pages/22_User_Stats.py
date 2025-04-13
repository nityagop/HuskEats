import logging
logger = logging.getLogger(__name__)

import streamlit as st
import pandas as pd
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('User Statistics')
users = requests.get('http://api:4000/a/users').json()
activeUserStatusUpdate = requests.put('http://api:4000/a/userStatus')
activeUsers = requests.get('http://api:4000/a/activeUsers').json()

col1, col2 = st.columns(2)

with col1:
    st.write('### Users')
    try:
        st.dataframe(users)
    except:
        st.write("**Important**: Could not connect to database to get users!")

with col2:
    st.write('### Active Users')
    try:
        st.dataframe(activeUsers)
    except:
        st.write("**Important**: Could not connect to database to get active users!")

users_data = pd.DataFrame(users)
activeUsers_data = pd.DataFrame(activeUsers)

total_users = users_data["Total Number of Users"].iloc[0]
active_users = activeUsers_data["Number of Active Users"].iloc[0]

combined_data = pd.DataFrame({
    "User Type": ["Total Users", "Active Users"],
    "Number of Users": [total_users, active_users]
})

st.write('##### User Statistics vs Active Users')
st.bar_chart(
    combined_data,
    x="User Type",
    color=["#C8A2C8"],
    y="Number of Users",
    height=500,
    )