import logging

logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
from datetime import date

SideBarLinks()

user_id = st.session_state.get("user_id")
user_id = 1 # for testing purposes
restaurant_id = st.session_state.get("restaurant_id")
restaurant_name = st.session_state.get("restaurant_name", "Unknown Restaurant")
#Header
st.header(f"Leave a Review for {restaurant_name}!")

# Inputs
title = st.text_input("Review Title")
rating = st.radio("Rating", [1, 2, 3, 4, 5])
content = st.text_area("Review Content")

#Submission of Reviews
if st.button("Submit Review"):
  data = {"title": title,"rating": rating,"content": content}

  endpoint = f"http://localhost:4000/s/reviews/{user_id}/{restaurant_id}"
  try:
        userLastUseDateUpdate = requests.put(f"http://api:4000/s/userLastUseDate/{user_id}")
        response = requests.post(f"http://api:4000/s/reviews/{user_id}/{restaurant_id}", json=data)
  except:
        st.write(f"Failed to update reviews/{user_id}/{restaurant_id}")
  if response.status_code == 200:
        st.write("Review Created!")