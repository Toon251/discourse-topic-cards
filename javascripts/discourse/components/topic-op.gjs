import UserLink from "discourse/components/user-link";
import avatar from "discourse/helpers/avatar";

export default class LikeToggle extends Component {
  @tracked name = 'Hello'; // ค่าเริ่มต้นที่สามารถเปลี่ยนแปลงได้

  updateName(newName) {
    this.name = newName; // อัปเดตค่า name
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
        {{this.name}}
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
