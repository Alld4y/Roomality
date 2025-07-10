import { Hono } from "hono";
import type { Context } from "hono";
import { Pool } from "pg";
 
const userRoutes = new Hono();
const pool = new Pool({
    user: process.env.PGUSER,
    host: process.env.PGHOST,
    database: process.env.PGDATABASE,
    password: process.env.PGPASSWORD,
    port: Number(process.env.PGPORT),
});

userRoutes.post('/register',async (ctx: Context)=>{
    try {
        const body = await ctx.req.json();
        const sql = `INSERT INTO "Dorm"."user"(username, password, email, uid) VALUES ($1, $2, $3, $4);`;
        const uuid = Bun.randomUUIDv7()
        console.log(uuid);
        pool.query(sql,[body.username, body.password,body.email,uuid]);
        return ctx.text("User Register Successfully", 201);
    } catch (error) {
        return ctx.text("User Register Failed", 500);
    }
});

userRoutes.post('/login',async (ctx: Context)=> {
    try {
        const body = await ctx.req.json();
        console.log(body);
        const sql = 'SELECT * FROM "Dorm"."user" WHERE username = $1';
        const queryRes = pool.query(sql,[body.username]);
        const resRows = (await queryRes).rows[0];
        console.log(resRows.password)
        if(resRows.password == body.password){
            console.log("Succesfully");
            return ctx.text("Login Successfully",500)
        }else{
            return ctx.text("Login Faild",201)
        }
    } catch (error) {
        console.log("Error");

        return ctx.text("Login Failed",201)
    }
});


export default userRoutes;