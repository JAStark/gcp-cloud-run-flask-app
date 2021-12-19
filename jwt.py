from create_jwt_from_sa import generate_jwt

sa_keyfile = 'credentials/silver-antonym-326607-6291c19c51a9.json'
sa_email = 'cloud-run-endpoint-sa@silver-antonym-326607.iam.gserviceaccount.com'
expire = 300  # you can set some integer
aud = # $AUD_URL

jwt = generate_jwt(sa_keyfile, sa_email, expire, aud)
