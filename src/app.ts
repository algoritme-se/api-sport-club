import fastify from "fastify";
import { appRoutes } from "./http/routes";
import { ZodError } from "zod";
import { env } from "./env";
import fastifyJwt from "@fastify/jwt";
import fastifyCookie from "@fastify/cookie";

export const app = fastify()
app.register(fastifyJwt, {
  secret: env.JWT_SECRET,
  cookie: {
    cookieName: 'refreshToken',
    signed: false,
  },
  sign: {
    expiresIn: '1h',
  }
})
app.register(fastifyCookie)
app.register(appRoutes)

app.setErrorHandler((error, _request, reply) => {
  if (error instanceof ZodError) {
    return reply.status(400).send({ message: 'Validation failed', issues: error.format() })
  }

  if (env.NODE_ENV !== 'production') {
    console.log(error)
  } else {
    // TODO:implements Datadog error tracking
  }

  return reply.status(500).send({ message: 'Internal server error' })
})

