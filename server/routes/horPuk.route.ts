import { Hono } from "hono";
import type { Context } from "hono";
import { Pool } from "pg";


const horPukRoutes = new Hono(); //   /horPuk
const pool = new Pool({
    user: process.env.PGUSER,
    host: process.env.PGHOST,
    database: process.env.PGDATABASE,
    password: process.env.PGPASSWORD,
    port: Number(process.env.PGPORT),
});


horPukRoutes.post('/createHorPuk', async (ctx: Context) => {
    try {
        const body = await ctx.req.json();
        console.log('Parsing Json Body', body);

        const allRooms: any = [];

        body.rows.forEach((row: any)=>{
            row.floor.forEach((floor: any)=>{
                floor.rooms.forEach( async (room: any)=>{
                //console.log(room);
                const flattenedRoom = {
                    horPukName: body.horPukName,
                    rowName: row.rowName,
                    floorName: floor.floorName,
                    ...room,
                };
            
                allRooms.push(flattenedRoom);
                });
            });
        });
        console.log(allRooms);
        allRooms.forEach( async (room: any)=>{
            const result = await pool.query(`
            INSERT INTO "Dorm"."mainStructure" 
            ("roomName","monthlyPrice","floorName","rowName","horPukName","depositPrice", "rentalStart","contract","status") 
            VALUES ($1, $2, $3, $4, $5 , $6 , $7, $8 , $9)`,
            [room.roomName,room.monthlyPrice,room.floorName,room.rowName,room.horPukName,room.depositPrice,room.rentalStartUnix,room.contract, room.paymentStatus]
        );
        console.log(`เพิ่มห้องสำเร็จ`);
        console.log(`result = ${result}`);
        });
        return ctx.text('Received Json Body code successfully',201);
    } catch (err: unknown) {
        if(err instanceof Error){
            console.error(err.message);
            return ctx.text(err.message,500);
        }
    }
});

export default horPukRoutes;