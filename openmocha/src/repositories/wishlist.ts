import { EntityTarget, DataSource, Repository } from "typeorm";
import { Wishlist } from "../models/wishlist";

export class WishlistRepository extends Repository<Wishlist> {
  constructor(dataSource: DataSource) {
    // Extend the Repository class with the Wishlist entity.
    super(Wishlist as EntityTarget<Wishlist>, dataSource.manager);
  }
}
