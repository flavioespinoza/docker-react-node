require("dotenv").config();

const jwt = require("jsonwebtoken");
const axios = require("axios");
const _ = require("lodash");

const Koa = require("koa");
const Router = require("koa-router");
const combineRouters = require("koa-combine-routers");
const logger = require("koa-logger");
const cors = require("kcors");
const bodyParser = require("koa-bodyparser");
const request = require("request");
const log = require("ololog");

const PORT = process.env.HOST || 5000;
const jotform_api_key = process.env.JOTFORM_API_KEY;
// const jotform_api_key = "e6271df2300c9d7c4e5d3f6aba33ec1c";

const app = new Koa();
const loginRoute = new Router();

const _req_claim = async options => {
  return new Promise(async resolve => {
    request(options, async (error, response, body) => {
      if (error) throw new Error(error);
      let _body = JSON.parse(body);
      console.log(_body);
      resolve({
        status_code: response.statusCode,
        response_headers: response.headers,
        body: _body
      });
    });
  });
};

loginRoute.post("/api/openid-login", async (ctx, next) => {
  log.lightYellow(ctx.query);
  const email = ctx.query.email;

	log.lightBlue("jotform_api_key");
  log.lightBlue("jotform_api_key");
  log.lightBlue("jotform_api_key");
  log.lightBlue("jotform_api_key");
  log.blue("jotform_api_key", jotform_api_key);
  log.lightBlue("jotform_api_key");
  log.lightBlue("jotform_api_key");
  log.lightBlue("jotform_api_key");
  log.lightBlue("jotform_api_key");


  // const submission_id = 4428351239413163702;
  // const jotform_uri = `https://hipaa-api.jotform.com/submission/${submission_id}`;
  // const options = {
  // 	method: "GET",
  // 	url: jotform_uri,
  // 	qs: { apikey: jotform_api_key }
  // };
  // const claim = await _req_claim(options);
  // const answers_all = claim.body.content.answers;
  // const answers = [];
  // _.each(answers_all, (obj, key) => {
  // 	if (obj.answer) {
  // 		answers.push(obj);
  // 	}
  // });

  // log.magenta(answers)

  ctx.body = {
    success: true,
    email: email,
    claim: {
    	submission_id: 'claim.body.content.id',
    	answers: 'answers',
    	answers_all: 'answers_all'
    }
  };
  await next();
});

const router = combineRouters(loginRoute);

app.use(cors());
app.use(logger());
app.use(bodyParser());
app.use(router());

app.listen(PORT, () => log.lightMagenta(`Server listening on port ${PORT}`));
