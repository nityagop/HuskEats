import logging

logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
from datetime import date

SideBarLinks()
#Header
st.header("Leave a Review!")

# Inputs
user_id = st.session_state.get('user_id', '')
restaurant_id = st.text_input("Restaurant ID")

title = st.text_input("Review Title")
rating = st.radio("Rating", [1, 2, 3, 4, 5])
content = st.text_area("Review Content")
date_reported = st.date_input("Date", value=date.today())

#Submission of Reviews
if st.button("Submit Review"):
  data = {"title": title,"rating": rating,"content": content,"date_reported": str(date_reported)}

  endpoint = f"http://localhost:4000/reviews/{user_id}/{restaurant_id}"
  try:
        response = requests.put(f"http://api:4000/reviews/{user_id}/{restaurant_id}", json=data)
  except:
        st.write(f"Failed to update reviews/{user_id}/{restaurant_id}")
  if response.status_code == 200:
        st.write("Review Created!")