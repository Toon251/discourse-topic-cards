
import UserLink from "discourse/components/user-link";
import avatar from "discourse/helpers/avatar";

import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";

export default class TopicOpComponent extends Component {
  @tracked badges = []; // เก็บรายการ badge เพื่อแสดงใน template
  
  constructor() {
    super(...arguments);
    this.loadBadges(); // โหลด badges เมื่อ component ถูกเรียก
  }

  /**
   * Fetch badges for the topic creator via API
   */
  async loadBadges() {
    try {
      const username = this.args.topic.creator.username; // Assume user ID is available
      const response = await fetch(`/u/${username}.json`); // Replace with your actual API endpoint
      if (!response.ok) {
        throw new Error(`Failed to fetch badges: ${response.status}`);
      }
      const data = await response.json();
      console.log(data.badges)
      this.badges = data.badges; // Assuming `badges` is in the response structure
    } catch (error) {
      console.error("Error fetching badges:", error);
      this.badges = []; // Fallback in case of errors
    }
  }
}


const TopicOp = <template>
  <div class="topic-card__op">
    <UserLink @user={{@topic.creator}}>
      {{avatar @topic.creator imageSize="tiny"}}
      <span class="username">
        {{@topic.creator.username}}
      </span>
      <span>
        Test
      </span>
    </UserLink>
  </div>
</template>;

export default TopicOp;
