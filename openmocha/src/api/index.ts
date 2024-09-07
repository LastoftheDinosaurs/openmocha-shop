import { Router, json } from 'express'
import cors from 'cors'
import { projectConfig } from '../../medusa-config'
import wishlist from './wishlist'

const corsOptions = {
  origin: projectConfig.store_cors.split(','),
  credentials: true
}

export default () => {
  const app = Router()
  app.use(cors(corsOptions))

  wishlist(app)

  return app
}