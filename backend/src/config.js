require('dotenv').config();

module.exports={
  app:{
    port: process.env.PORT || 4000,
  },
  mysql: {
    host: process.env.MYSQL_HOST||'localhost',
    user: process.env.MYSQL_USER||'user',
    password: process.env.MYSQL_PASSWORD||'',
    database: process.env.MYSQL_DB||'ejemplo',
    
  }
}