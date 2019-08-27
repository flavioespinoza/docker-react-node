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

const PORT = process.event.HOST || 5000;

const app = new Koa();
const loginRoute = new Router();

loginRoute.post("/api/openid-login", async (ctx, next) => {
  log.lightYellow(ctx.query);
  const email = ctx.query.email;
  ctx.body = {
    success: true,
    email: email
  };
  await next();
});

const router = combineRouters(loginRoute);

app.use(cors());
app.use(logger());
app.use(bodyParser());
app.use(router());

app.listen(PORT, () => log.lightMagenta(`Server listening on port ${PORT}`));
