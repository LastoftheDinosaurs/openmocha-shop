import { EntityTarget, DataSource, Repository } from "typeorm";
import { WishlistItem } from '../models/wishlist-item';

export class WishlistItemRepository extends Repository<WishlistItem> {
  constructor(dataSource: DataSource) {
    // Extend the Repository class with the WishlistItem entity.
    super(WishlistItem as EntityTarget<WishlistItem>, dataSource.manager);
  }
}
