Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB11F578B63
	for <lists+target-devel@lfdr.de>; Mon, 18 Jul 2022 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbiGRT56 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 18 Jul 2022 15:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiGRT5r (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:57:47 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8002D1FE
        for <target-devel@vger.kernel.org>; Mon, 18 Jul 2022 12:57:45 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 75so22837873ybf.4
        for <target-devel@vger.kernel.org>; Mon, 18 Jul 2022 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=NzKrsOEUDJAHtXJ/3YQcQKAXgqqWuh59wbN+FZYhwzNoGCP1DCWerufiv+8vbKdqh8
         4gFWbOb/iyKAFT+xxOvuQ68Z3f85ts/NQjQx6FNgZeVa1HUn0RJw3E3/P3PN41P83H5G
         liOboMaE4kEpppYH0UAuJokwjnmhJWe+Gz04LSnOsGbNm6ASl0byTenreiX1srOC2jdn
         ahsjae5XwAWThgjoa54iEI69khJ4Ue26g3OjjFbo6h+4RY2qwJ47yoht0btXM9VbvcHi
         G9+uyyek3Fd7p/693tOzOyRKBPuLacYytv32dq6pyWmyZwKJWWFfaZZgMj+pklEbCTKr
         QO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=x/4X5J9w1VVryU9eclFZVOf5zaaRt9HZn8XRT/+GVGoiH6l3/d9sWqC7gCM1pP1lxP
         DHvticMlDNdnSURFNnBRtcwF21NIzm65RLRXUNxc+//RX4flceS98vCg3yOhGAfixC36
         sVB+YT7U9HUBo5ZYfvyXdsb+YndRLMG8fDxTB60LgB+qscY3dxEcx8Wn4CBdrkGvDV1w
         fWn99Y3BJ9fJnQlF9VwSAvzv2YxiRf/zCkDfEW+J8a7uTFKkD1X9ZQ0mF1xrT1ngG/oN
         1fWnrVqb+HPd0J2PaYrsgcYgf4c42AdVC/TIUy8p+UO6xd+0SLlwYCl3ZB8y5SJEf28n
         CEGQ==
X-Gm-Message-State: AJIora+Zd/kLs1CUMWoRlzPpdEZEIb5ZJKPc0dyynhJzIvog50znXL6n
        8ka+lSpbHZB2JD9AoSTT2LQ8Y5IUKUEazw6JdnU=
X-Google-Smtp-Source: AGRyM1sH7+gbGg0UshsiXZstF+hLoFjAGrPyBnSF74G21W6HobwMkanHtbrky4v88zMKZpFbOfLENfbFg0w48FTsPkY=
X-Received: by 2002:a25:587:0:b0:670:6034:81b8 with SMTP id
 129-20020a250587000000b00670603481b8mr3647582ybf.4.1658174264748; Mon, 18 Jul
 2022 12:57:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:34dd:0:0:0:0 with HTTP; Mon, 18 Jul 2022 12:57:44
 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <rayimemogn@gmail.com>
Date:   Mon, 18 Jul 2022 11:57:44 -0800
Message-ID: <CAMefwTOVxz0RyX8-7firORdsW5jX-9Dk3My=PH-+N4hSMx+mbg@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Dear,

My name is Dr Lily William from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
