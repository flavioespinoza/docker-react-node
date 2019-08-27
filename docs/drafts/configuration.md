
# Configuration (Required)

You must customize the environment to use different values for the Node Environment Variables. To do this, create a new file called `.env` in your root directory of the project, with the following environment variables:

```bash
# ------------------------------------------------------------------------------------------
# Node Backend & React Frontend
# ------------------------------------------------------------------------------------------
NODE_ENV="production"

HOST=5000

AUTH_ENV=prod

NODE_PATH=./src

PRISMA_MANAGEMENT_API_SECRET="your_api_key"

SENGRID_KEY="your_api_key"

JOTFORM_API_KEY="your_api_key"

# OpenID Connect Credentials
CLIENT_ID="your_client_id"
CLIENT_SECRET="your_client_secret"

URI_REDIRECT=http://localhost:8080/auth/openIdClient/redirect

URI_HOST=https://ra-authnet.resilient-networks.com/
URI_HOST_PD=https://exemplar.pd.authnet.webshield.io
​
URI_OPENID=https://ra-authnet.resilient-networks.com/openId/
URI_OPENID_PD=https://exemplar.pd.authnet.webshield.io:844/
​
URI_AUTH=https://ra-authnet.resilient-networks.com/openId/authenticate
URI_AUTH_PD=https://ra-authnet.resilient-networks.com/openId/authenticate
​
URI_TOKEN=https://ra-authnet.resilient-networks.com/openId/token
URI_TOKEN_PD=https://exemplar.pd.authnet.webshield.io:844/resilientAccess_token

URI_USERINFO=https://ra-authnet.resilient-networks.com/openId/userinfo
URI_USERINFO_PD=https://exemplar.pd.authnet.webshield.io:844/resilientAccess_userInfo

URI_LOGOUT=https://ra-authnet.resilient-networks.com/openId/logout
URI_LOGOUT_PD=https://exemplar.pd.authnet.webshield.io:844/resilientAccess_logout
​
SCOPE="openid admin profile email"
```