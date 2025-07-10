import { Hono } from "hono";
import horPukRoutes from "./horPuk.route";
import roomRoutes from "./room.route";
import userRoutes from "./user.route";

const apiRoutes = new Hono(); //   routing

console.log("Server start");

// Moute Routing
apiRoutes.route('/user',userRoutes);
apiRoutes.route('/horPuk', horPukRoutes);
apiRoutes.route('/room', roomRoutes);

export default apiRoutes;
