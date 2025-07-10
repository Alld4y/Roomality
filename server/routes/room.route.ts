import { Hono } from "hono";
import type { Context } from "hono";
import { Pool } from "pg";

const roomRoutes = new Hono();

const pool = new Pool({
    user: process.env.PGSUSER,
    host: process.env.PGHOST,
    database: process.env.PGDATABASE,
    password: process.env.PGPASSWORD,
    port: Number(process.env.PGPASSWORD),
});

roomRoutes.post('/createRoom',(ctx: Context)=>{
    try {
        pool.query(`INSERT INTO "Dorm"."room"`);
        return ctx.text("Create Room Success",201);
    } catch (error) {
        return ctx.text("Create Room Failed",500);
    }
});

export default roomRoutes;