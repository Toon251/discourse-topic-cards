
import Component from "@glimmer/component";
import { inject as service } from "@ember/service";

export default class TopicOpComponent extends Component {
  @service store; // Service เชื่อมกับ Ember Data

  /**
   * Method to fetch topic creator's badges dynamically if not preloaded
   */
  async fetchUserBadges(userId) {
    if (!this.args.topic.creator.badges || this.args.topic.creator.badges.length === 0) {
      const user = await this.store.findRecord("user", userId, { include: "badges" });
      return user.badges;
    }
    return this.args.topic.creator.badges;
  }
}


import UserLink from "discourse/components/user-link";
import avatar from "discourse/helpers/avatar";



const TopicOp = <template>
  <div class="topic-card__op">
    <UserLink @user={{@topic.creator}}>
      {{avatar @topic.creator imageSize="tiny"}}
      <span class="username">
        {{@topic.creator.username}}
      </span>
      <span>
        {{#each @topic.creator.badges as |badge|}}
          <span class="badge">
            <i class="fa {{badge.icon}}"></i> {{badge.name}}
          </span>
        {{/each}}
      </span>
    </UserLink>
  </div>
</template>;

export default TopicOp;
