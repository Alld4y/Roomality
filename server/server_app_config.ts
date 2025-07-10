// // server.ts
// const port = 3000;

// const server = Bun.serve({
//     port: port,
//     fetch: async (req: Request) => {
//         const url = new URL(req.url);
//         const path = url.pathname;
//         const method = req.method;

//         console.log(`Incoming Request: ${method} ${path}`);

//         // CORS Headers สำหรับการพัฒนา (สำคัญมากสำหรับ Flutter)
//         const corsHeaders = {
//             'Access-Control-Allow-Origin': '*', // อนุญาตทุกโดเมน
//             'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS', // อนุญาตเมธอดเหล่านี้
//             'Access-Control-Allow-Headers': 'Content-Type', // ลบ 'Authorization' ออกจาก Headers ที่อนุญาต
//         };

//         // จัดการ Preflight OPTIONS request (CORS)
//         if (method === 'OPTIONS') {
//             return new Response(null, { status: 204, headers: corsHeaders });
//         }

//         // --- ลบส่วนการตรวจสอบ API Key ออกไปทั้งหมด ---
//         // const authHeader = req.headers.get('Authorization');
//         // if (!authHeader || !authHeader.startsWith('Bearer ')) {
//         //     console.warn('Unauthorized: Missing or invalid Authorization header');
//         //     return new Response(JSON.stringify({ error: 'Unauthorized' }), {
//         //         status: 401, // Unauthorized
//         //         headers: { ...corsHeaders, 'Content-Type': 'application/json' }
//         //     });
//         // }
//         // const receivedApiKey = authHeader.split(' ')[1];
//         // if (receivedApiKey !== EXPECTED_API_KEY) {
//         //     console.warn('Forbidden: Incorrect API Key');
//         //     return new Response(JSON.stringify({ error: 'Forbidden: Incorrect API Key' }), {
//         //         status: 403, // Forbidden
//         //         headers: { ...corsHeaders, 'Content-Type': 'application/json' }
//         //     });
//         // }
//         // --- สิ้นสุดส่วนที่ถูกลบ ---

//         // --- POST Requests ---
//         if (method === 'POST') {
//             // Endpoint สำหรับ /api/rooms
//             if (path === '/api/rooms') { // แก้ไขเป็น /api/rooms ตามที่ได้คุยกัน
//                 try {
//                     const roomData = await req.json(); // รับ JSON body
//                     console.log('--- Received Room Data (from Flutter) ---');
//                     console.log(roomData);
//                     const responseData = { 
//                         message: 'Room data received and processed!', 
//                         receivedData: roomData,
//                         id: Math.floor(Math.random() * 1000) + 1 // ตัวอย่าง ID ที่สร้างขึ้น
//                     };
//                     return new Response(JSON.stringify(responseData), {
//                         status: 201, // 201 Created เหมาะสำหรับ POST
//                         headers: { ...corsHeaders, 'Content-Type': 'application/json' }
//                     });
//                 } catch (error) {
//                     console.error('Error parsing JSON for /api/rooms:', error);
//                     return new Response(JSON.stringify({ error: 'Invalid JSON or server error for rooms' }), {
//                         status: 400, // Bad Request
//                         headers: { ...corsHeaders, 'Content-Type': 'application/json' }
//                     });
//                 }
//             }
//             // Endpoint สำหรับ /api/horpuk
//          else if (path === '/api/horpuk') {
//     try {
//         const horPukData:any = await req.json(); // รับ JSON body
//         console.log('--- Received HorPuk Data (from Flutter) ---');
//         console.log(JSON.stringify(horPukData, null, 2)); // <<-- เปลี่ยนตรงนี้เพื่อให้เห็นโครงสร้างเต็ม
//         // console.log(horPukData); // <<-- บรรทัดนี้สามารถลบออกได้ หากคุณไม่ต้องการเห็น [object Object]

//         const responseData = { 
//             message: 'HorPuk data received and processed!', 
//             receivedData: horPukData,
//             id: Math.floor(Math.random() * 1000) + 1 
//         };

//         console.log(`horPukData Name: ${horPukData.horPukName}`); // <<-- จะแสดงชื่อหอพักอย่างเดียว
//         return new Response(JSON.stringify(responseData), {
//             status: 201,
//             headers: { ...corsHeaders, 'Content-Type': 'application/json' }
//         });
//     } catch (error) {
//         console.error('Error parsing JSON for /api/horpuk:', error);
//         // ...
//     }
// }
//             // Endpoint สำหรับ /api/sync
//             else if (path === '/api/sync') {
//                 try {
//                     const syncData = await req.json();
//                     console.log('--- Received Sync Data (from Flutter) ---');
//                     console.log(syncData);
//                     const responseData = { 
//                         message: 'Sync data received and processed!', 
//                         receivedData: syncData,
//                     };
//                     return new Response(JSON.stringify(responseData), {
//                         status: 200, // OK
//                         headers: { ...corsHeaders, 'Content-Type': 'application/json' }
//                     });
//                 } catch (error) {
//                     console.error('Error parsing JSON for /api/sync:', error);
//                     return new Response(JSON.stringify({ error: 'Invalid JSON or server error for sync' }), {
//                         status: 400,
//                         headers: { ...corsHeaders, 'Content-Type': 'application/json' }
//                     });
//                 }
//             }
//         }

//         // --- GET Requests (ตัวอย่าง) ---
//         if (method === 'GET') {
//             if (path === '/api/rooms') {
//                 // ตัวอย่างส่งข้อมูล Rooms กลับไป (สมมติว่าดึงจาก DB มาได้)
//                 const dummyRooms = [
//                     { roomName: "A101", monthlyPrice: 5000, roomStatus: "VACANT" },
//                     { roomName: "A102", monthlyPrice: 6000, roomStatus: "OCCUPIED" },
//                 ];
//                 return new Response(JSON.stringify(dummyRooms), {
//                     status: 200,
//                     headers: { ...corsHeaders, 'Content-Type': 'application/json' }
//                 });
//             } else if (path === '/api/horpuk') {
//                 // ตัวอย่างส่งข้อมูล HorPuk กลับไป
//                 const dummyHorPuk = [
//                     {
//                         horPukName: "หอพักทดสอบ Bun",
//                         rows: [
//                             { rowName: "A", floor: [{ floorName: "1", rooms: [{ roomName: "A-1-1", monthlyPrice: 7000 }] }] }
//                         ]
//                     }
//                 ];
//                 return new Response(JSON.stringify(dummyHorPuk), {
//                     status: 200,
//                     headers: { ...corsHeaders, 'Content-Type': 'application/json' }
//                 });
//             }
//         }

//         // ถ้าไม่ใช่ Endpoint ที่รู้จัก
//         return new Response('Not Found', { status: 404, headers: corsHeaders });
//     }
// });

// console.log(`Bun Server Listening on http://localhost:${port}`);
// console.log(`For Flutter App on Android Emulator, use http://10.0.2.2:${port}`);
// console.log(`For Flutter App on Physical Device/iOS Simulator, use your local IP (e.g., http://192.168.0.229:${port})`);

import { Hono } from "hono";
import { cors } from "hono/cors";
import apiRoutes from "./routes/api.routes";
import dotenv from "dotenv";
dotenv.config();


const api = new Hono(); //  /api

api.use('/api/*',cors({
    origin: '*',
    allowMethods: ['GET','POST'],
    allowHeaders: ['Content-Type','Authorization'],
}));

api.route('/api', apiRoutes);
api.get('/',(ctx) => ctx.text("Roomality is running on BunJs"));
api.all('*', (ctx) => {
    return ctx.json({ message: 'Not Found', status: 404 }, 404);
});


Bun.serve({
    port: 3000,
    fetch: api.fetch,
});


//export default api;