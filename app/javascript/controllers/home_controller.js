import { Controller } from "stimulus";

export default class extends Controller {
   static values = {
      roomIdentifier: String
   }

   join_room() {
      console.log(this.roomIdentifierValue)
   }
}
