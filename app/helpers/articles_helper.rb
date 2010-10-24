# -*- coding: undecided -*-
module ArticlesHelper

  def article_author_link( article )
    string = 
    unless article.custom_author.blank?
      unless article.custom_author_link.blank?
        %Q{<a href="#{article.custom_author_link}" target="_blank">#{article.custom_author}</a>}
      else
        article.custom_author
      end
    else
      if article.user
        link_to( article.user.name, article.user, :target => '_blank' )
      else
        I18n.t('misc.author_unknown')
      end
    end

    string
  end

  def article_photographer_link( article )
    string =
    unless article.photographer.blank?
      if article.photographer_link.blank?
        article.photographer
      else
        %Q{<a href="#{article.photographer_link}" , target="_blank">#{article.photographer}</a>}
      end
    else
      ''
    end

    string
  end

  def article_source_link( article )
    string =
    unless article.source.blank?
      if article.source_link.blank?
        article.source
      else
        %Q{ <a href="#{article.source_link}" target="_blank">#{article.source}</a> }
      end
    end
    
    string
  end
  
  def article_footer( article )
    footer_content = []
    unless ( author = article_author_link( article ) ).blank?
      footer_content.push %Q{#{ I18n.t( 'activerecord.attributes.article.author' ) }: #{ author } }
    end

    unless ( photographer = article_photographer_link( article ) ).blank?
      footer_content.push %Q{#{ I18n.t( 'activerecord.attributes.article.photographer' ) }: #{ photographer } }
    end

    unless ( source = article_source_link( article ) ).blank?
      footer_content.push %Q{#{ I18n.t( 'activerecord.attributes.article.source' ) }: #{ source } }
    end

    if article.publish_date
      # TODO replace to_s(:short) to styled_date call
      footer_content.push %Q{ #{ I18n.t( 'activerecord.attributes.article.publish_date' ) }: #{ article.publish_date.to_s( :short ) } }
    end

    return footer_content.join('<br />')
  end
end
