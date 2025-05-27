
import UserLink from "discourse/components/user-link";
import avatar from "discourse/helpers/avatar";

import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";

export default class TopicOpComponent extends Component {
  @tracked badges = []; // เก็บรายการ badge เพื่อแสดงใน template
  var apiUrl = settings.apiUrl;
  
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
      //const response = await fetch(`/u/${username}.json`); // Replace with your actual API endpoint
      // https://connect-app.efinancethai.com/public-api
      console.log(this.apiUrl)
      const response = await fetch(`${this.apiUrl}/user/${username}/badges`); 
      if (!response.ok) {
        throw new Error(`Failed to fetch badges: ${response.status}`);
      }
      const result = await response.json();
      console.log(username, result);

      if(result.success){
        this.badges = result.data; // Assuming `badges` is in the response structure
      }
    
      
    } catch (error) {
    
      this.badges = []; // Fallback in case of errors
      setTimeout("loadBadges", 2000);
    }
    
  }

  <template>
    <div class="topic-card__op">
      <UserLink @user={{@topic.creator}}>
        {{avatar @topic.creator imageSize="tiny"}}
        <span class="username">
          {{@topic.creator.username}}
        </span>
        <span> 
          {{#if this.badges.length}}
            <span class="topic-user-badge-list">
            {{#each this.badges as |badge|}}
                {{#if badge.allow_title}}
                  <span class="topic-user-badge">
                      {{#if badge.image_url}}
                        <img src="{{badge.image_url}}" class="topic-badge-image" width="30" height="30" alt="{{badge.name}}"/>
                      {{/if}}
                      <span class="topic-badge-name">{{badge.name}}</span>
                  </span>
                {{/if}}
              {{/each}}
            </span>
          {{/if}}
        </span>
      </UserLink>
    </div>
  </template>
}