
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
