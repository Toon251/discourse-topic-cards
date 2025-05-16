import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { tracked } from "@glimmer/tracking";

export default class TopicOpComponent extends Component {
  @service store;
  @tracked badges = [];

  constructor() {
    super(...arguments);
    this.loadBadges(); // Load badges initially
  }

  async loadBadges() {
    this.badges = await this.fetchUserBadges(this.args.topic.creator.id);
  }

  async fetchUserBadges(userId) {
    if (!this.args.topic.creator.badges || this.args.topic.creator.badges.length === 0) {
      const user = await this.store.findRecord("user", userId, { include: "badges" });
      return user.badges.toArray(); // Convert Ember Data Relational Model to Array
    }
    return this.args.topic.creator.badges;
  }
}